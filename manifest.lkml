project_name: "app-sales-config"

remote_dependency: app-sales-adapter  {
  url: "https://github.com/looker/app-sales-fivetran-bigquery"
  ref: "4f1386b4aefbf48c70f8a76946bc82e409a1f251"
}

remote_dependency: app-sales {
  url: "https://github.com/looker/app-sales/"
  ref: "1f398c15a30e6914cc0633c48d297f34e4ebae2c"
}


# local_dependency: {project: "app-sales"}
# local_dependency: {project: "app-sales-adapter"}
