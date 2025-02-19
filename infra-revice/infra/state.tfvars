 # leave empty comes from each env state-files
    bucket = "dev-ops-state-manupa"
    key    = "server/${each.key}.tfstate"
    region = "ap-south-1"