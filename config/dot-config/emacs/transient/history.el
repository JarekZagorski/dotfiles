((magit-am
  ("--3way"))
 (magit-commit
  ("--verbose"))
 (magit-diff
  ("--stat" "--no-ext-diff")
  ("--no-ext-diff" "--ignore-submodules=all"))
 (magit-diff:--ignore-submodules)
 (magit-dispatch nil)
 (magit-log
  ("-n256" "--graph" "--decorate"))
 (magit-notes nil)
 (magit-push nil)
 (magit-stash nil)
 (magit-status-jump nil))
