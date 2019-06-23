Add-Type -AssemblyName System.Speech
$synthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
$synthesizer.Speak('Работать, блядь!')

$synthesizer.GetInstalledVoices() | ForEach-Object { $_.VoiceInfo }