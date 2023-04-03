# What is the hard limit for this quota in AWS?

**The goal of this project is to provide a CLI to supplement
the Service Quotas API/CLI, so that hard limits can be checked
in an automated manner.**

While AWS provides **soft limit** information through the Service Quotas API, they do **not**
provide information about the **hard limits** for these quotas. While soft limits are
important for making small adjustments, they don't tell you when you are getting close
to a critical threshold. 

The structure of the data and the provided CLI interface intentionally mimics that of the
Service Quotas CLI [list-service-quotas](https://docs.aws.amazon.com/cli/latest/reference/service-quotas/list-service-quotas.html) command.

The goal (at least initially) is to capture the hard limits **for quotas that are adjustable**. 
If a quota is not adjustable, then the hard limit and the default value are the same. This information
is already available from the service-quotas API/CLI.

## CLI Interface

The aws-hard-limits.sh script reads the data from GitHub for a given service code and returns it, optionally filtered by a quota code.
```shell
./aws-hard-limits.sh --service-code iam --quota-code L-C07B4B0D
```

## Hard Limit Data

The data returned by the CLI comes directly from GitHub. 
The structure of the repository is simple. There is one JSON file for each service code:
```
/aws-services/{service-code}.json
```

Each JSON file defines an array which includes the ServiceCode, ServiceName, QuotaCode, QuotaName, MaxValue, and Source.
```json
[
    {
        "ServiceCode": "iam",
        "ServiceName": "AWS Identity and Access Management (IAM)",
        "QuotaCode": "L-C07B4B0D",
        "QuotaName": "Role trust policy length",
        "MaxValue": 4096,
        "Source": "https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html"
    }
]
```

## TODO
* EKS max 1000 nodes per cluster
* MSK max 3 serverless clusters per account

## Contribution

Since the data supporting this interface must be manually scraped from various AWS documentation sources,
contributions are greatly appreciated. The values may become obsolete without regular updates.

### How can I find a hard limit, so that I can contribute?

Suggest Googling for [`"aws" "quota" "up to a maximum"`](https://www.google.com/search?q=%22aws%22+%22quota%22+%22up+to+a+maximum%22) or some variant thereof. These are not advertised in any consistent manner and sometimes require direct communication with AWS support to discover. That's exactly what this project aims to solve.
