# Курсор
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "(default)" -PropertyType String -Value "Черная (крупная)" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name AppStarting -PropertyType ExpandString -Value "%SystemRoot%\cursors\wait_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Arrow -PropertyType ExpandString -Value "%SystemRoot%\cursors\arrow_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name ContactVisualization -Value 1 -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Crosshair -PropertyType ExpandString -Value "%SystemRoot%\cursors\cross_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name GestureVisualization -Value 31 -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Hand -PropertyType ExpandString -Value "" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Help -PropertyType ExpandString -Value "%SystemRoot%\cursors\help_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name IBeam -PropertyType ExpandString -Value "%SystemRoot%\cursors\beam_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name No -PropertyType ExpandString -Value "%SystemRoot%\cursors\no_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name NWPen -PropertyType ExpandString -Value "%SystemRoot%\cursors\pen_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Scheme Source" -Value 2 -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeAll -PropertyType ExpandString -Value "%SystemRoot%\cursors\move_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNESW -PropertyType ExpandString -Value "%SystemRoot%\cursors\size1_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNS -PropertyType ExpandString -Value "%SystemRoot%\cursors\size4_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNWSE -PropertyType ExpandString -Value "%SystemRoot%\cursors\size2_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeWE -PropertyType ExpandString -Value "%SystemRoot%\cursors\size3_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name UpArrow -PropertyType ExpandString -Value "%SystemRoot%\cursors\up_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Wait -PropertyType ExpandString -Value "%SystemRoot%\cursors\busy_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Pin -PropertyType ExpandString -Value "%SystemRoot%\cursors\pin_rm.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Person -PropertyType ExpandString -Value "%SystemRoot%\cursors\person_rm.cur" -Force

#
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name UserPreferencesMask -PropertyType Binary -Value ([byte[]](0x9e, 0x5e, 0x07, 0x80, 0x12, 0x00, 0x00, 0x00)) -Force

#
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseSpeed -PropertyType String -Value 1 -Force
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold1 -PropertyType String -Value 6 -Force
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold2 -PropertyType String -Value 10 -Force


$Signature = @{
	Namespace = "SystemParamInfo"
	Name = "WinAPICall"
	Language = "CSharp"
	MemberDefinition = @"
		[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
		public static extern bool SystemParametersInfo(
		uint uiAction,
		uint uiParam,
		uint pvParam,
		uint fWinIni);
"@
}
IF (-not ("SystemParamInfo.WinAPICall" -as [type]))
{
	Add-Type @Signature
}
[SystemParamInfo.WinAPICall]::SystemParametersInfo(0x0057,0,$null,0)