using CardValidation.Core.Enums;
using CardValidation.Core.Services.Interfaces;
using CardValidation.Infrustructure;
using CardValidation.ViewModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Abstractions;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Routing;
using Moq;

namespace CardValidationUnitTests
{
    public class CreditCardValidationFilterTests
    {
        [Test]
        public void CheckOnActionExecuting_WhenParametersAreValid()
        {
            // Arrange
            var _validationService = Mock.Of<ICardValidationService>();
            Mock.Get(_validationService).Setup(x => x.GetPaymentSystemType(It.IsAny<string>())).Returns(PaymentSystemType.MasterCard);
            CreditCardValidationFilter _creditCardValidationFilter  = new CreditCardValidationFilter(_validationService);

            var modelState = new ModelStateDictionary();
            var actionContext = new ActionContext(Mock.Of<HttpContext>(), Mock.Of<RouteData>(), Mock.Of<ActionDescriptor>(), modelState);

            CreditCard creditCardValues = new CreditCard() {  Owner = "Christoper Nolan", Cvv="089", Date= "02/6174", Number= "4111111111111111" };

            Dictionary<string, object> creditCard = new Dictionary<string, object>();
            creditCard.Add("creditCard", creditCardValues);

            // Actual 
            _creditCardValidationFilter.OnActionExecuting(new ActionExecutingContext(actionContext, new List<IFilterMetadata>(), creditCard, Mock.Of<Controller>()));

            // Assert
            Assert.IsTrue(true);
        }

        [Test]
        public void CheckOnActionExecuting_WhenOneParameterIsNull()
        {
            // Arrange
            var _validationService = Mock.Of<ICardValidationService>();
            Mock.Get(_validationService).Setup(x => x.GetPaymentSystemType(It.IsAny<string>())).Returns(PaymentSystemType.MasterCard);
            CreditCardValidationFilter _creditCardValidationFilter = new CreditCardValidationFilter(_validationService);

            var modelState = new ModelStateDictionary();
            var actionContext = new ActionContext(Mock.Of<HttpContext>(), Mock.Of<RouteData>(), Mock.Of<ActionDescriptor>(), modelState);

            CreditCard creditCardValues = new CreditCard() { Owner = null, Cvv = "089", Date = "02/6174", Number = "4111111111111111" };

            Dictionary<string, object> creditCard = new Dictionary<string, object>();
            creditCard.Add("creditCard", creditCardValues);

            // Actual 
            _creditCardValidationFilter.OnActionExecuting(new ActionExecutingContext(actionContext, new List<IFilterMetadata>(), creditCard, Mock.Of<Controller>()));

            // Assert
            Assert.IsTrue(true);
        }

        [Test]
        public void CheckOnActionExecuting_WhenParametersIsNull_ReturnsInvalidOperationException()
        {
            // Arrange
            var _validationService = Mock.Of<ICardValidationService>();
            Mock.Get(_validationService).Setup(x => x.GetPaymentSystemType(It.IsAny<string>())).Returns(PaymentSystemType.MasterCard);
            CreditCardValidationFilter _creditCardValidationFilter = new CreditCardValidationFilter(_validationService);

            var modelState = new ModelStateDictionary();
            var actionContext = new ActionContext(Mock.Of<HttpContext>(), Mock.Of<RouteData>(), Mock.Of<ActionDescriptor>(), modelState);

            Dictionary<string, object> creditCard = new Dictionary<string, object>();
            creditCard.Add("creditCard", null);

            // Actual 


            // Assert
            Assert.Throws<InvalidOperationException>(() => _creditCardValidationFilter.OnActionExecuting(new ActionExecutingContext(actionContext, new List<IFilterMetadata>(), creditCard, Mock.Of<Controller>())));
        }

        [Test]
        public void CheckOnActionExecuted()
        {
            // Arrange
            var _validationService = Mock.Of<ICardValidationService>();
            Mock.Get(_validationService).Setup(x => x.GetPaymentSystemType(It.IsAny<string>())).Returns(PaymentSystemType.MasterCard);
            CreditCardValidationFilter _creditCardValidationFilter = new CreditCardValidationFilter(_validationService);

            var modelState = new ModelStateDictionary();
            var actionContext = new ActionContext(Mock.Of<HttpContext>(), Mock.Of<RouteData>(), Mock.Of<ActionDescriptor>(), modelState);

            // Actual 
            _creditCardValidationFilter.OnActionExecuted(new ActionExecutedContext(actionContext, new List<IFilterMetadata>(), Mock.Of<Controller>()));

            // Assert
            Assert.True(true);
        }


    }
}