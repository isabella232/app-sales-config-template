project_name: "app-sales-config"

# remote_dependency: app-sales-adapter  {
#   url: "https://github.com/looker/app-sales-fivetran-bigquery"
#   ref: "7428c70eeb0eb5131380439fa1a7fb2fc8509b67"
# }

# remote_dependency: app-sales {
#   url: "https://github.com/looker/app-sales/"
#   ref: "5df05153bfbbf9004efdba3433baadacb194e255"
# }

local_dependency: {project: "app-sales"}
local_dependency: {project: "app-sales-adapter"}
