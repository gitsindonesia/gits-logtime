import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';
import 'package:dcli/posix.dart';
import 'package:gits_logtime/helper/print_helper.dart';
import 'package:gits_logtime/models/config.dart';
import 'package:gits_logtime/models/project.dart';
import 'package:gits_logtime/models/workspace.dart';
import 'package:gits_logtime/service/service.dart';
import 'package:path/path.dart';

import '../helper/config_helper.dart';

class InitCommand extends Command {
  @override
  String get name => 'init';

  @override
  String get description => 'Init a new config hooks';

  @override
  void run() async {
    PrintHelper.info(
        'Generate and get your api key clockyfy from https://app.clockify.me//user/settings');
    final apiKey = ask('API Key:');
    final user = await Service.getUser(apiKey);
    final workspaces = await Service.getWorkspaces(apiKey);
    final selectedWorkspace = menu(
      prompt: 'Choose your workspace:',
      format: (Workspace workspace) => workspace.name,
      options: workspaces,
    );
    final projects = await Service.getProjects(apiKey, selectedWorkspace.id);
    final selectedProjects = menu(
      prompt: 'Choose your project:',
      format: (Project project) => project.name,
      options: projects,
    );

    final confirmed = confirm('''

Yourname: ${user.name}
Workspace: ${selectedWorkspace.name}
Project: ${selectedProjects.name}

Are you sure its correct?''', defaultValue: false);

    if (!confirmed) return;
    createConfig(
      Config(
        apiKey: apiKey,
        userId: user.id,
        workspaceId: selectedWorkspace.id,
        projectId: selectedProjects.id,
        startTime: DateTime.now(),
      ),
    );
    createPostCommitHook();
    createPostCheckoutHook();
    createCommitMessageHook();

    PrintHelper.success(
        'Config gits logtime & git hooks file created for this repository');
  }

  void createPostCommitHook() {
    final path = join(current, '.git', 'hooks', 'post-commit');
    path.write('''#!/bin/sh

BRANCH_NAME=\$(git branch | grep '*' | sed 's/* //')

if [[ \$BRANCH_NAME != *"no branch"* ]]; then
    message=\$(git log -1 --pretty=%B)
    gits-logtime add "\$message"
fi''');

    chmod(path, permission: '755');
    PrintHelper.generated(path);
  }

  void createPostCheckoutHook() {
    final path = join(current, '.git', 'hooks', 'post-checkout');
    path.write('''#!/bin/sh

gits-logtime change-time
''');

    chmod(path, permission: '755');
    PrintHelper.generated(path);
  }

  void createCommitMessageHook() {
    final path = join(current, '.git', 'hooks', 'commit-msg');
    path.write('''#!/bin/sh

BRANCH_NAME=\$(git branch | grep '*' | sed 's/* //')

if [[ \$BRANCH_NAME != *"no branch"* ]]; then
    gits-logtime check-commit
fi''');

    chmod(path, permission: '755');
    PrintHelper.generated(path);
  }
}
