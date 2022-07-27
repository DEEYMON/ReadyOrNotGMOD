/** Ready Or Not
 * @ Author: deymon
 * @ Create Time: 2022-03-18 13:24:58
 * @ Modified by: deymon
 * @ Modified time: 2022-06-27 23:25:55
 */

GM.Name = "Ready Or Not"
GM.Author = "deymon"
GM.Version = "1.0.0"
GM.Github = "https://github.com/DEEYMON/ReadyOrNotGMOD"
GM.Workshop = ""
RON = RON or {}

print("\n###"..GM.Name)
print("Version:"..GM.Version)
print("Workshop:"..GM.Workshop.."\n")


function RON:Log(message,success)

    local isSuccess = isbool(success) and ( success and "Success! " or "Error! " ) or ""
    print("[RON] " .. isSuccess .. message)

end