using Microsoft.AspNetCore.Http;
using MongoDB.Driver;
using Nest;
using System.Threading.Tasks;

namespace WebApplication.Middleware
{
    public class HealthyCheck
    {
        private MongoClient _mongoClient;
        private ElasticClient _elasticClient;

        public HealthyCheck(RequestDelegate next, MongoClient mongoClient, ElasticClient elasticClient)
        {
            _mongoClient = mongoClient;
            _elasticClient = elasticClient;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            var db = await _mongoClient.ListDatabaseNamesAsync();
            var temp = await _elasticClient.Indices.ExistsAsync(new IndexExistsRequest(Indices.All));
            await context.Response.WriteAsync("works fine");
        }
    }
}
