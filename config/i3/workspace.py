import i3ipc
i3 = i3ipc.Connection()
def on_workspace(event, data):
    workspaces = i3.get_workspaces()
    if len(workspaces) == 1 and workspaces[0].name != "1":
        i3.command('workspace 1')
i3.on('workspace::empty', on_workspace)
i3.main()
