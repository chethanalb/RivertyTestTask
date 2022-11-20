using AutoFixture;
using CardValidation.Core.Enums;
using CardValidation.Core.Services.Interfaces;
using CardValidation.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace CardValidationUnitTests
{
    public class CardValidationControllerTests
    {
        [Test]
        public void CheckValidateCreditCard_WhenModelStateIsValid_ReturnsOkResult()
        {
            // Arrange
            Fixture fixture = new Fixture();
            var creditCard  = fixture.Create<CreditCard>();

            var _validationService = Mock.Of<ICardValidationService>();
            Mock.Get(_validationService).Setup(x => x.GetPaymentSystemType(It.IsAny<string>())).Returns(PaymentSystemType.MasterCard);

            // Actual 
            var obj = new CardValidation.Controllers.CardValidationController(_validationService);
            var result = obj.ValidateCreditCard(creditCard);
            var contentResult = result as OkObjectResult;

            // Assert
            Assert.That(contentResult.StatusCode, Is.EqualTo(200));
            Assert.That(contentResult.Value, Is.EqualTo(PaymentSystemType.MasterCard));
        }

        [Test]
        public void CheckValidateCreditCard_WhenModelStateIsValid_ReturnsBadRequestResult()
        {
            // Arrange
            var _validationService = Mock.Of<ICardValidationService>();
            Mock.Get(_validationService).Setup(x => x.GetPaymentSystemType(It.IsAny<string>())).Returns(PaymentSystemType.MasterCard);

            // Actual 
            var obj = new CardValidation.Controllers.CardValidationController(_validationService);
            obj.ModelState.AddModelError("key", "error message");
            var result = obj.ValidateCreditCard(new CreditCard());
            var contentResult = result as BadRequestObjectResult;

            // Assert
            Assert.That(contentResult.StatusCode, Is.EqualTo(400));
        }

    }
}