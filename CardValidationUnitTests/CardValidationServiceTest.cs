using CardValidation.Core.Enums;
using CardValidation.Core.Services;
namespace CardValidationUnitTests
{
    public class CardValidationServiceTests
    {
        [Test]
        public void CheckGetPaymentSystemType_WhenPaymentSystemTypeIsVisa_ReturnsVisa()
        {
            // Arrange
            string creditCardNumber  = "4111111111111111";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            PaymentSystemType result = _cardValidationService.GetPaymentSystemType(creditCardNumber);

            // Assert
            Assert.That(result, Is.EqualTo(PaymentSystemType.Visa));
        }

        [Test]
        public void CheckGetPaymentSystemType_WhenPaymentSystemTypeIsMasterCard_ReturnsMasterCard()
        {
            // Arrange
            string creditCardNumber = "5105105105105100";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            PaymentSystemType result = _cardValidationService.GetPaymentSystemType(creditCardNumber);

            // Assert
            Assert.That(result, Is.EqualTo(PaymentSystemType.MasterCard));
        }

        [Test]
        public void CheckGetPaymentSystemType_WhenPaymentSystemTypeIsAmericanExpress_ReturnsAmericanExpress()
        {
            // Arrange
            string creditCardNumber = "378282246310005";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            PaymentSystemType result = _cardValidationService.GetPaymentSystemType(creditCardNumber);

            // Assert
            Assert.That(result, Is.EqualTo(PaymentSystemType.AmericanExpress));
        }

        [Test]
        public void CheckGetPaymentSystemType_WhenCreditCardNumberIsInvalidNumber_ReturnsNotImplementedException()
        {
            // Arrange
            string creditCardNumber = "InvalidNumber";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();

            // Assert
            Assert.Throws<NotImplementedException>(() => _cardValidationService.GetPaymentSystemType(creditCardNumber));
        }

        [Test]
        public void CheckValidateNumber_WhenCreditCardNumberIsVisa_ReturnsTrue()
        {
            // Arrange
            string creditCardNumber = "4111111111111111";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateNumber(creditCardNumber);

            // Assert
            Assert.That(result, Is.EqualTo(true));
        }

        [Test]
        public void CheckValidateNumber_WhenCreditCardNumberIsMaster_ReturnsTrue()
        {
            // Arrange
            string creditCardNumber = "5105105105105100";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateNumber(creditCardNumber);

            // Assert
            Assert.That(result, Is.EqualTo(true));
        }

        [Test]
        public void CheckValidateNumber_WhenCreditCardNumberIsAmericanExpress_ReturnsTrue()
        {
            // Arrange
            string creditCardNumber = "378282246310005";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateNumber(creditCardNumber);

            // Assert
            Assert.That(result, Is.EqualTo(true));
        }

        [Test]
        public void CheckValidateNumber_WhenCreditCardNumberIsInvalid_ReturnsFalse()
        {
            // Arrange
            string creditCardNumber = "InvalidNumber";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateNumber(creditCardNumber);

            // Assert
            Assert.That(result, Is.EqualTo(false));
        }

        [Test]
        public void CheckValidateCvc_WhenCVCIsInvalid_ReturnsFalse()
        {
            // Arrange
            string cvcNumber = "invalidNumber";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateCvc(cvcNumber);

            // Assert
            Assert.That(result, Is.EqualTo(false));
        }

        [Test]
        public void CheckValidateCvc_WhenCVCIsValid_ReturnsTrue()
        {
            // Arrange
            string cvcNumber = "0456";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateCvc(cvcNumber);

            // Assert
            Assert.That(result, Is.EqualTo(true));
        }

        [Test]
        public void CheckValidateOwner_WhenOwnerIsValid_ReturnsTrue()
        {
            // Arrange
            string owner = "Christoper Nolan";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateOwner(owner);

            // Assert
            Assert.That(result, Is.EqualTo(true));
        }

        [Test]
        public void CheckValidateOwner_WhenOwnerIsInValid_ReturnsFalse()
        {
            // Arrange
            string owner = "456";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateOwner(owner);

            // Assert
            Assert.That(result, Is.EqualTo(false));
        }

        [Test]
        public void CheckValidateIssueDate_WhenIssueDateIsInValid_ReturnsFalse()
        {
            // Arrange
            string issueDate = "456";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateIssueDate(issueDate);

            // Assert
            Assert.That(result, Is.EqualTo(false));
        }

        [Test]
        public void CheckValidateIssueDate_WhenIssueDateIsValid_ReturnsTrue()
        {
            // Arrange
            string issueDate = "02/6174";

            // Actual 
            CardValidationService _cardValidationService = new CardValidationService();
            bool result = _cardValidationService.ValidateIssueDate(issueDate);

            // Assert
            Assert.That(result, Is.EqualTo(true));
        }
    }
}