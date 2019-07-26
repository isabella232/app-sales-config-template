project_name: "app-sales-config"

remote_dependency: app-sales-adapter  {
  url: "https://github.com/looker/app-sales-fivetran-bigquery"
  ref: "ce34e98e4c3d0dc32111cfba7836f1d28b0187b8"
}

remote_dependency: app-sales {
  url: "https://github.com/looker/app-sales/"
  ref: "eccaff89662da5ac0763b629145578673b459d80"
}

application: sales-analytics-application {
  label: "Sales Analytics (Template)"
  definition_file: "app-sales//application.json"
}

# local_dependency: {project: "app-sales"}
# local_dependency: {project: "app-sales-adapter"}
