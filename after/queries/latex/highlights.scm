; extends

(generic_command
  command: (command_name) @_name
  (#eq? @_name "\\red")
  arg: (curly_group) @custom.red)


(generic_command
  command: (command_name) @_name
  (#eq? @_name "\\comment")
  arg: (curly_group) @custom.comment)

(generic_command
  command: (command_name) @_name
  (#eq? @_name "\\previous")
  arg: (curly_group) @custom.previous)

(generic_command
  command: (command_name) @_name
  (#eq? @_name "\\suggest")
  arg: (curly_group) @custom.suggest)
