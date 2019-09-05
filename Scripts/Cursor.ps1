New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "(default)" -PropertyType String -Value "Windows Black" -Force

New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name AppStarting -Type ExpandString -Value "%SystemRoot%\cursors\wait_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Arrow -Type ExpandString -Value "%SystemRoot%\cursors\arrow_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Crosshair -Type ExpandString -Value "%SystemRoot%\cursors\cross_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Hand -Type ExpandString -Value "" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Help -Type ExpandString -Value "%SystemRoot%\cursors\help_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name IBeam -Type ExpandString -Value "%SystemRoot%\cursors\beam_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name No -Type ExpandString -Value "%SystemRoot%\cursors\no_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name NWPen -Type ExpandString -Value "%SystemRoot%\cursors\pen_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeAll -Type ExpandString -Value "%SystemRoot%\cursors\move_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNESW -Type ExpandString -Value "%SystemRoot%\cursors\size1_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNS -Type ExpandString -Value "%SystemRoot%\cursors\size4_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNWSE -Type ExpandString -Value "%SystemRoot%\cursors\size2_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeWE -Type ExpandString -Value "%SystemRoot%\cursors\size3_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name UpArrow -Type ExpandString -Value "%SystemRoot%\cursors\up_r.cur" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Wait -Type ExpandString -Value "%SystemRoot%\cursors\busy_r.cur" -Force

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