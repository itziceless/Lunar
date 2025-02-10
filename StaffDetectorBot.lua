local HttpService = game:GetService("HttpService")
local Webhook_URL = "https://discord.com/api/webhooks/1338566143157338142/UaslejQy1CoSq7cZhEPHlmMICxnU_WccTWttBRT8yasR4nww6MVDNwpkI3W-eJwnh7qE"

local report = http.request(
{
    Url = Webhook_URL,
    Method = 'POST',
    Headers = {
        ['Content-Type'] = 'application/json'
    },
    Body = HttpService:JSONEncode({
        ["Content"] = "",
        ["embeds"] = {{
            ["title"] = "Staff Detected",
            ["description"] = "Impossible_Join",
            ["type"] = "rich",
            ["color"] = tonumber(0xffffff),
            ["fields"] = {
                {
                    ["name"] = "Staff User:",
                    ["value"] = game:GetService("RbxAnalyticsService"):GetClientId(),
                    ["inline"] = true
                }
            }
        }}
    })
}
)
