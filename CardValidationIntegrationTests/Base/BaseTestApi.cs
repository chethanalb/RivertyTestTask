using CardValidationIntegrationTests.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CardValidationIntegrationTests.BaseTest;

public class BaseTestApi
{
    public string GetJsonData(string ExpectedResponse)
    {
        var path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,"../../../ResponseJsons/Response.json");
        String Text = File.ReadAllText(path);
        dynamic response = JsonConvert.DeserializeObject(Text);
        return $"{response[ExpectedResponse]}";
    }
    
    public Method GetRestSharpMethodType(String methodType)
    {
        Method Type = Method.Get;
        switch(methodType) 
        {
            case "Get":
                Type = Method.Get;
                break;
            case "Post":
                Type = Method.Post;
                break;
        }

        return Type;
    }
}