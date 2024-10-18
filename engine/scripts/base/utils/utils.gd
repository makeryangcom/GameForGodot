#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

extends Node

## 验证邮箱格式
func check_mail_format(mail:String) -> bool:
	var check:bool = true
	var regex = RegEx.new()
	regex.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")
	if !regex.search(mail):
		check = false
	return check

## 获取当前时间
func get_current_time() -> String:
	var current_time = Time.get_time_dict_from_system()
	var hour = current_time.hour
	var minute = current_time.minute
	var second = current_time.second
	if hour < 10:
		hour = "0" + str(hour)
	if minute < 10:
		minute = "0" + str(minute)
	if second < 10:
		second = "0" + str(second)
	return str(hour) + ":" + str(minute) + ":" + str(second)

## 获取当前时间[小时]
func get_current_hour() -> int:
	var current_time = Time.get_time_dict_from_system()
	return current_time.hour
