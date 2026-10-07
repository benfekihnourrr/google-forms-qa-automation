# ============================================================
# GOOGLE FORMS QA AUTOMATION TOOL
# Customer Experience Feedback - Demo
#
# Generates synthetic TEST responses for a Google Form
# that you own/control.
# ============================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Net.ServicePointManager]::Expect100Continue = $false

# ------------------------------------------------------------
# SETTINGS
# ------------------------------------------------------------

$NumberOfTests = 10
$DelaySeconds = 2

$formUrl = "https://docs.google.com/forms/d/e/1FAIpQLSfNjFyFtuGrX2DmBrWi-TY0rg5Gln9oW2x6wMMceR5_A5zRNQ/formResponse"

$userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0.0.0 Safari/537.36"


# ------------------------------------------------------------
# RANDOM SELECTION FUNCTION
# ------------------------------------------------------------

function Select-Random {
    param($Array)

    return $Array[(Get-Random -Minimum 0 -Maximum $Array.Count)]
}


# ------------------------------------------------------------
# TEST DATA
# ------------------------------------------------------------

$customerTypes = @(
    "New customer",
    "Returning customer",
    "Business customer"
)

$services = @(
    "Website Development",
    "Automation",
    "Consultation",
    "Technical Support"
)

$qualityOptions = @(
    "Very Poor",
    "Poor",
    "Average",
    "Good",
    "Excellent"
)

$easeOptions = @(
    "Very Difficult",
    "Difficult",
    "Neutral",
    "Easy",
    "Very Easy"
)

$supportOptions = @(
    "Immediately",
    "Within 1 hour",
    "Within 24 hours",
    "Within 2–3 days"
)

$recommendOptions = @(
    "Definitely not",
    "Probably not",
    "Maybe",
    "Probably",
    "Definitely"
)

$featureOptions = @(
    "Easy Interface",
    "Fast Service",
    "Automation",
    "Customer Support",
    "Reporting"
)

$feedbackOptions = @(
    "Synthetic test response - everything worked correctly.",
    "Synthetic test response - the process was easy to use.",
    "Synthetic test response - automation worked as expected.",
    "Synthetic test response - support experience was good.",
    "Synthetic test response - interface was clear and simple."
)


# ------------------------------------------------------------
# COUNTERS
# ------------------------------------------------------------

$Successful = 0
$Failed = 0


# ------------------------------------------------------------
# SUBMIT TEST RESPONSE
# ------------------------------------------------------------

function Submit-TestResponse {

    param(
        [int]$TestNumber
    )

    # Generate synthetic data

    $customerType = Select-Random $customerTypes
    $service = Select-Random $services

    $satisfaction = Get-Random -Minimum 1 -Maximum 6

    $quality = Select-Random $qualityOptions
    $ease = Select-Random $easeOptions
    $support = Select-Random $supportOptions
    $recommend = Select-Random $recommendOptions
    $feature = Select-Random $featureOptions

    $useAgain = Get-Random -Minimum 1 -Maximum 6

    $feedback = Select-Random $feedbackOptions


    # --------------------------------------------------------
    # GOOGLE FORM FIELD MAPPING
    # --------------------------------------------------------

    $formData = @{

        # Customer type
        "entry.1700480343" = $customerType

        # Service used
        "entry.286691630" = $service

        # Satisfaction (1-5)
        "entry.235931682" = $satisfaction.ToString()

        # Quality
        "entry.188448258" = $quality

        # Ease of process
        "entry.1931432499" = $ease

        # Support speed
        "entry.1081987991" = $support

        # Recommendation
        "entry.1579128785" = $recommend

        # Most useful feature
        "entry.1677872630" = $feature

        # Use service again (1-5)
        "entry.1433678527" = $useAgain.ToString()

        # Additional feedback
        "entry.1748159492" = $feedback

        # Google Forms metadata
        "pageHistory" = "0"
        "fvv" = "1"
    }


    # --------------------------------------------------------
    # DISPLAY GENERATED TEST DATA
    # --------------------------------------------------------

    Write-Host ""
    Write-Host "[$TestNumber/$NumberOfTests] Generating synthetic test response..." -ForegroundColor Yellow
    Write-Host ""

    Write-Host " Customer Type : $customerType" -ForegroundColor Cyan
    Write-Host " Service       : $service" -ForegroundColor Cyan
    Write-Host " Satisfaction  : $satisfaction/5" -ForegroundColor Cyan
    Write-Host " Quality       : $quality" -ForegroundColor Cyan
    Write-Host " Process       : $ease" -ForegroundColor Cyan
    Write-Host " Support       : $support" -ForegroundColor Cyan
    Write-Host " Recommendation: $recommend" -ForegroundColor Cyan
    Write-Host " Feature       : $feature" -ForegroundColor Cyan
    Write-Host " Use Again     : $useAgain/5" -ForegroundColor Cyan

    Write-Host ""


    # --------------------------------------------------------
    # SUBMIT
    # --------------------------------------------------------

    try {

        $response = Invoke-WebRequest `
            -Uri $formUrl `
            -Method POST `
            -Body $formData `
            -UseBasicParsing `
            -UserAgent $userAgent `
            -ContentType "application/x-www-form-urlencoded"


        if ($response.StatusCode -eq 200) {

            Write-Host " [OK] TEST SUBMISSION SUCCESSFUL" -ForegroundColor Green

            $script:Successful++

        }
        else {

            Write-Host " [FAILED] HTTP Status: $($response.StatusCode)" -ForegroundColor Red

            $script:Failed++

        }

    }

    catch {

        Write-Host " [ERROR] $($_.Exception.Message)" -ForegroundColor Red

        $script:Failed++

    }

}


# ============================================================
# START QA TEST
# ============================================================

Clear-Host

Write-Host ""
Write-Host "====================================================" -ForegroundColor Magenta
Write-Host "          GOOGLE FORMS QA AUTOMATION TOOL" -ForegroundColor Magenta
Write-Host "====================================================" -ForegroundColor Magenta

Write-Host ""
Write-Host " Customer Experience Feedback - Demo"
Write-Host ""
Write-Host " Mode        : Synthetic Test Data"
Write-Host " Test Count  : $NumberOfTests"
Write-Host " Delay       : $DelaySeconds seconds"

Write-Host ""
Write-Host "====================================================" -ForegroundColor Magenta


# ------------------------------------------------------------
# RUN TESTS
# ------------------------------------------------------------

for ($i = 1; $i -le $NumberOfTests; $i++) {

    Submit-TestResponse -TestNumber $i

    if ($i -lt $NumberOfTests) {

        Write-Host ""
        Write-Host " Waiting $DelaySeconds seconds..." -ForegroundColor DarkGray

        Start-Sleep -Seconds $DelaySeconds

    }

}


# ============================================================
# FINAL REPORT
# ============================================================

Write-Host ""
Write-Host ""
Write-Host "====================================================" -ForegroundColor Magenta
Write-Host "                 QA TEST COMPLETE" -ForegroundColor Magenta
Write-Host "====================================================" -ForegroundColor Magenta

Write-Host ""

Write-Host " Successful : $Successful" -ForegroundColor Green
Write-Host " Failed     : $Failed" -ForegroundColor Red
Write-Host " Total      : $NumberOfTests"

Write-Host ""
Write-Host " Synthetic test submissions completed." -ForegroundColor Cyan

Write-Host ""
Write-Host "====================================================" -ForegroundColor Magenta