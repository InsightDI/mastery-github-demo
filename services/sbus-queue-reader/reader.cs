using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace demo
{
    public static class reader
    {
        [FunctionName("reader")]
        public static void Run([ServiceBusTrigger("dev-mastery-sbus", Connection = "devmasterysbusns_SERVICEBUS")]string myQueueItem, ILogger log)
        {
            string badSecret = "Endpoint=sb://dev-mastery-sbus-ns.servicebus.windows.net/;SharedAccessKeyName=dev-mastery-owner-sbus-rule;SharedAccessKey=pyA6dZXK0/U347ZPaNmPgND+PlDsteJ7EsTigu7bwNk=;EntityPath=dev-mastery-sbus";

            string badSecret2 = "Endpoint=sb://dev-mastery-sbus-ns.servicebus.windows.net/;SharedAccessKeyName=dev-mastery-owner-sbus-rule;SharedAccessKey=Ls17MskDKK6Gq3MhFfXREqK+lPSyi4s56M9N7lHXFhk=;EntityPath=dev-mastery-sbus";

            log.LogInformation($"C# ServiceBus queue trigger function processed message: {myQueueItem}");
        }
    }
}
