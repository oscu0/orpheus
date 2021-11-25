import os
import re

from mstodo import icons
from mstodo.auth import is_authorised
from mstodo.sync import background_sync_if_necessary, sync
from mstodo.util import workflow

COMMAND_PATTERN = re.compile(r'^[^\w\s]+', re.UNICODE)
ACTION_PATTERN = re.compile(r'^\W+', re.UNICODE)


def route(args):
    handler = None
    command = []
    command_string = ''
    action = 'none'
    logged_in = is_authorised()

    # Read the stored query, which will correspond to the user's alfred query
    # as of the very latest keystroke. This may be different than the query
    # when this script was launched due to the startup latency.
    if args[0] == '--stored-query':
        query_file = workflow().workflowfile('.query')
        with open(query_file, 'r') as f:
            command_string = workflow().decode(f.read())
        os.remove(query_file)
    # Otherwise take the command from the first command line argument
    elif args:
        command_string = args[0]

    command_string = re.sub(COMMAND_PATTERN, '', command_string)
    command = re.split(r' +', command_string)

    if command:
        action = re.sub(ACTION_PATTERN, '', command[0]) or 'none'

    if 'about'.find(action) == 0:
        from mstodo.handlers import about
        handler = about
    elif not logged_in:
        from mstodo.handlers import login
        handler = login
    elif 'folder'.find(action) == 0:
        from mstodo.handlers import taskfolder
        handler = taskfolder
    elif 'task'.find(action) == 0:
        from mstodo.handlers import task
        handler = task
    elif 'search'.find(action) == 0:
        from mstodo.handlers import search
        handler = search
    elif 'due'.find(action) == 0:
        from mstodo.handlers import due
        handler = due
    elif 'upcoming'.find(action) == 0:
        from mstodo.handlers import upcoming
        handler = upcoming
    elif 'completed'.find(action) == 0:
        from mstodo.handlers import completed
        handler = completed
    elif 'logout'.find(action) == 0:
        from mstodo.handlers import logout
        handler = logout
    elif 'pref'.find(action) == 0:
        from mstodo.handlers import preferences
        handler = preferences
    # If the command starts with a space (no special keywords), the workflow
    # creates a new task
    elif not command_string:
        from mstodo.handlers import welcome
        handler = welcome
    else:
        from mstodo.handlers import new_task
        handler = new_task

    if handler:
        if '--commit' in args:
            modifier = re.search(r'--(alt|cmd|ctrl|fn)\b', ' '.join(args))

            if modifier:
                modifier = modifier.group(1)

            handler.commit(command, modifier)
        else:
            handler.filter(command)

            if workflow().update_available:
                update_data = workflow().cached_data('__workflow_update_status', max_age=0)

                if update_data.get('version') != '0.1.2':
                    workflow().add_item('An update is available!', 'Update the ToDo workflow from version 0.1.2 to %s' % update_data.get('version'), arg='-about update', valid=True, icon=icons.DOWNLOAD)

            workflow().send_feedback()
    
    if logged_in:
        background_sync_if_necessary()
        # sync() #@TODO change before pushing to Github
