project_name: "app-sales-config"

remote_dependency: app-sales-adapter  {
  url: "https://github.com/looker/app-sales-fivetran-bigquery"
  ref: "b09c89c429d33faecd5aaa5acd05cb91ce1c3070"
}

remote_dependency: app-sales {
  url: "https://github.com/looker/app-sales/"
  ref: "e09807318541e49def68ee551041649a093025e1"
}

# application: sales-app {
#   label: "Sales Analytics"
#   definition_file: "app-sales//application.json"
# }

# local_dependency: {project: "app-sales"}
# local_dependency: {project: "app-sales-adapter"}
