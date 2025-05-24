--lol you know why this is here
local HttpService = game:GetService("HttpService")

local CatFactFetcher = {}
CatFactFetcher._cache = nil
CatFactFetcher._cacheTime = 0
CatFactFetcher._cacheDuration = 300 -- seconds

function CatFactFetcher:GetFact()
    local now = os.time()
    if self._cache and now - self._cacheTime < self._cacheDuration then
        return self._cache
    end

    local success, response = pcall(function()
        return game:HttpGet("https://catfact.ninja/fact", true)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        local fact = data.fact or "Cats are mysterious creatures."
        self._cache = fact
        self._cacheTime = now
        return fact
    else
        return self._cache or "Could not fetch cat fact. Try again later."
    end
end

return CatFactFetcher
