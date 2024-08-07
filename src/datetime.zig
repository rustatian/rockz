pub const DateTime = struct {
    year: u16,
    month: u8,
    day: u8,
    hour: u8,
    minute: u8,
    second: u8,

    // https://de.wikipedia.org/wiki/Unixzeit#Beispiel-Implementierung
    pub fn from_timestamp(ts: u64) DateTime {
        const SECONDS_PER_DAY = 86400;
        const DAYS_PER_YEAR = 365;
        const DAYS_IN_4YEARS = 1461;
        const DAYS_IN_100YEARS = 36524;
        const DAYS_IN_400YEARS = 146097;
        const DAYS_BEFORE_EPOCH = 719468;

        const seconds_since_midnight: u64 = @rem(ts, SECONDS_PER_DAY);
        var day_n: u64 = DAYS_BEFORE_EPOCH + ts / SECONDS_PER_DAY;
        var temp: u64 = 0;

        temp = 4 * (day_n + DAYS_IN_100YEARS + 1) / DAYS_IN_400YEARS - 1;
        var year: u16 = @intCast(100 * temp);
        day_n -= DAYS_IN_100YEARS * temp + temp / 4;

        temp = 4 * (day_n + DAYS_PER_YEAR + 1) / DAYS_IN_4YEARS - 1;
        year += @intCast(temp);
        day_n -= DAYS_PER_YEAR * temp + temp / 4;

        var month: u8 = @intCast((5 * day_n + 2) / 153);
        const day: u8 = @intCast(day_n - (@as(u64, @intCast(month)) * 153 + 2) / 5 + 1);

        month += 3;
        if (month > 12) {
            month -= 12;
            year += 1;
        }

        return DateTime{ .year = year, .month = month, .day = day, .hour = @intCast(seconds_since_midnight / 3600), .minute = @intCast(seconds_since_midnight % 3600 / 60), .second = @intCast(seconds_since_midnight % 60) };
    }
};
