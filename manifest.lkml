project_name: "app-sales-config"

remote_dependency: app-sales-adapter  {
  url: "https://github.com/looker/app-sales-fivetran-bigquery"
  ref: "4f1386b4aefbf48c70f8a76946bc82e409a1f251"
}

remote_dependency: app-sales {
  url: "https://github.com/looker/app-sales/"
  ref: "e09807318541e49def68ee551041649a093025e1"
}


# local_dependency: {project: "app-sales"}
# local_dependency: {project: "app-sales-adapter"}
