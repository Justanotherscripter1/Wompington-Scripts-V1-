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
        return HttpService:GetAsync("https://cat-fact.herokuapp.com/facts/random")
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        local fact = data.text or "Cats are mysterious creatures."
        self._cache = fact
        self._cacheTime = now
        return fact
    else
        return self._cache or "Could not fetch cat fact. Try again later."
    end
end

return CatFactFetcher
