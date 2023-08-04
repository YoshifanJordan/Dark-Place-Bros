local GonerBackground, super = Class(Object)

function GonerBackground:init(x, y, song, song_pitch_gradually_increases)
    super.init(self,
        x or SCREEN_WIDTH/2, y or SCREEN_HEIGHT/2,
        -- specifically, LW dimensions
        SCREEN_WIDTH/2, SCREEN_HEIGHT/2
    )
    self:setScale(2)
    self:setOrigin(0, 0)

    self.parallax_x = 0
    self.parallax_y = 0

    self.piece_depth = 0

    self.timer = Timer()
    self.timer:every(40/30, function()
        self.piece_depth = self.piece_depth - 0.001
        local piece = self:addChild(GonerBackgroundPiece())
        piece.layer = self.piece_depth
    end)
    self:addChild(self.timer)

    song = song or "AUDIO_ANOTHERHIM"
    if song_pitch_gradually_increases == nil then
        song_pitch_gradually_increases = true
    end

    local music_pitch = 0.02
    self.music_target_pitch = song == "AUDIO_ANOTHERHIM" and 0.8 or 1
    if not song_pitch_gradually_increases then
        music_pitch = 1
        self.music_target_pitch = 1
    end
    self.music_pitch_inc = 0.02
    self.music = Music(song, 1, music_pitch)
end

function GonerBackground:onRemove(...)
    super.onRemove(self, ...)

    self.music:stop()
end

function GonerBackground:update()
    self.music:setPitch(
        Utils.approach(self.music:getPitch(), self.music_target_pitch,
        self.music_pitch_inc * DTMULT)
    )

    super.update(self)
end

return GonerBackground