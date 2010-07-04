(library (surfage s98 os-environment-variables)
  (export
    get-environment-variable
    get-environment-variables)
  (import
    (only (system)
          get-environment-variable
          get-environment-variables)))
