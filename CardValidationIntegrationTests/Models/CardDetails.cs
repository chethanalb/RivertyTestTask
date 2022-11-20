using System;

namespace CardValidationIntegrationTests.Models;

public class CardDetails
{
    public String owner { get; set; }
    public String number { get; set; }
    public String date { get; set; }
    public String cvv { get; set; }
}