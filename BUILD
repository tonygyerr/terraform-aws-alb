# Terraform init Build Targets
filegroup(
    labels = [
        "cognito",
        "deploy",
        "plan",
    ],
    name = "cognito_pkg",
    srcs = glob([
        "*.tf",
        "commands/*.sh",
        "env-config/*.tfvars",
        "examples/*.tf",
    ]),
)

# commands
sh_binary(
    labels = [
        "cognito",
    ],
    deps = [
        ":cognito_pkg",
    ],
    main = "commands/destroy.sh",
    name = "destroy_exe",
)

sh_binary(
    labels = [
        "cognito",
    ],
    deps = [
        ":cognito_pkg",
    ],
    main = "commands/plan.sh",
    name = "plan_exe",
)

sh_binary(
    labels = [
        "cognito",
    ],
    deps = [
        ":cognito_pkg",
    ],
    main = "commands/apply.sh",
    name = "apply_exe",
)