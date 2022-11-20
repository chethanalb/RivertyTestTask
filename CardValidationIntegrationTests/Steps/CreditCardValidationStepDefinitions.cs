using System;
using System.Net;
using Newtonsoft.Json;
using NUnit.Framework;
using RestSharp;
using CardValidationIntegrationTests.Models;
using CardValidationIntegrationTests.BaseTest;
using Microsoft.VisualStudio.TestPlatform.ObjectModel.Client;

namespace CardValidationIntegrationTests.Steps
{
    [Binding]
    public sealed class CreditCardValidationStepDefinitions
    {
        private String BaseUrl = "http://localhost:7135";
        private RestClient Client;
        private RestRequest Request;
        RestResponse Response;
        private readonly ScenarioContext _scenarioContext;
        private BaseTestApi BaseApi;
        

        public CreditCardValidationStepDefinitions(ScenarioContext scenarioContext)
        {
            _scenarioContext = scenarioContext;
            BaseApi = new BaseTestApi();
             Client = new RestClient(BaseUrl);
        }

        [Given(@"I create a new card data (.*),(.*),(.*),(.*)")]
        public void GivenICreateANewCardData(string Name, string Number, string IssueDate, string CVV)
        {
            Request = new RestRequest("/CardValidation/card/credit/validate", Method.Post);
            Request.RequestFormat = DataFormat.Json;
            Request.AddHeader("Content-Type" , "application/json");
            Request.AddBody(new CardDetails() { owner = Name, number = Number, date = IssueDate, cvv = CVV });
            
        }

        [When(@"I send the request to server")]
        public void WhenISendTheRequestToServer()
        {
            Response = Client.Execute(Request);
        }

        [Then(@"the server should return (.*),(.*)")]
        public void ThenTheServerShouldReturn(int ExpectedStatus, string ExpectedResponseData)
        {
            string expectedResponse = BaseApi.GetJsonData(ExpectedResponseData);
            string obj =  JsonConvert.DeserializeObject<dynamic>(Response.Content).ToString();
            Assert.AreEqual( ExpectedStatus ,(int)Response.StatusCode);
            Assert.AreEqual(expectedResponse, obj);
           
        }
        
        [Given(@"I create card data for new endpoint (.*),(.*),(.*),(.*),(.*),(.*)")]
        public void GivenICreateCardDataWithBaseUrlJaneDoe(string MethodType ,string EndPoint,string Name, string Number, string IssueDate, string CVV)
        {
            this.Request = new RestRequest(EndPoint, BaseApi.GetRestSharpMethodType(MethodType));
            this.Request.RequestFormat = DataFormat.Json;
            this.Request.AddBody(new CardDetails() { owner = Name, number = Number, date = IssueDate, cvv = CVV });
        }

        [When(@"I send the request to server with header (.*)")]
        public void WhenISendTheRequestToServerWithHeader(String ContentType)
        {
            Request.AddHeader("Content-Type" , ContentType);
            Response = this.Client.Execute(Request);
        }

        [Then(@"the server should return (.*)")]
        public void ThenTheServerShouldReturn(int ExpectedStatus)
        {
            Assert.AreEqual( ExpectedStatus ,(int)this.Response.StatusCode);
        }
    }
}