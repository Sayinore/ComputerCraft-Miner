password = "123456"

while true do

  term.clear()
  term.setCursorPos(1,1)
  textutils.slowPrint("Please input password!")
  
  input = read('*')
  
  if password == input then
    textutils.slowPrint("Hi, owner!")
    rs.setOutput("back",true)
    sleep(3)
    rs.setOutput("back",false)
  else
    textutils.slowPrint("Go away!")
    textutils.slowPrint("You're not the owner!")
    sleep(0.5)
  end
end
