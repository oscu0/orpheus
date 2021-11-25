from mstodo import icons
from mstodo.util import workflow

def filter(args):
    workflow().add_item(
        'New task...',
        'Begin typing to add a new task',
        autocomplete=' ',
        icon=icons.TASK_COMPLETED
    )

    workflow().add_item(
        'Due today',
        'Due and overdue tasks',
        autocomplete='-due ',
        icon=icons.TODAY
    )

    workflow().add_item(
        'Upcoming',
        'Tasks due soon',
        autocomplete='-upcoming ',
        icon=icons.UPCOMING
    )

    workflow().add_item(
        'Completed',
        'Tasks recently completed',
        autocomplete='-completed ',
        icon=icons.YESTERDAY
    )

    workflow().add_item(
        'Find and update tasks',
        'Search or browse by folder',
        autocomplete='-search ',
        icon=icons.SEARCH
    )

    workflow().add_item(
        'New folder',
        autocomplete='-folder ',
        icon=icons.LIST_NEW
    )

    workflow().add_item(
        'Preferences',
        autocomplete='-pref ',
        icon=icons.PREFERENCES
    )

    workflow().add_item(
        'About',
        'Learn about the workflow and get support',
        autocomplete='-about ',
        icon=icons.INFO
    )