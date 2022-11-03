# aws-hard-limits
Repository for storage of AWS Hard Limits, which are **not** currently available from AWS Service Quotas API.

## "What is the hard limit for this in AWS?"

While AWS provides **soft limit** information through the Service Quotas API, they do not
provide information about the **hard limits** for these quotas. While soft limits are
important for making small adjustments, they don't tell you when you are getting close
to a critical threshold. 

_**The goal of this project is to provide a CLI shim to supplement
the Service Quotas API/CLI, so that hard limits can be checked 
in an automated manner.**_

The structure of the data and CLI interface intentionally mimics that of the
Service Quotas CLI [list-service-quotas](https://docs.aws.amazon.com/cli/latest/reference/service-quotas/list-service-quotas.html) command.

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

The goal is to capture the hard limits **for quotas that are adjustable**. If a quota is not adjustable, the
hard limit and the default value are the same (and is already available from the service-quotas API/CLI).

## Contribution

Since the data supporting this interface must be manually scraped from various AWS documentation sources,
contributions are greatly appreciated. The values may become obsolete without regular updates.