return {
    forgetmenot = function(cutscene, event)
        local flaurel = cutscene:getCharacter("flaurel")
        local player = Game.world.player
        local susie = cutscene:getCharacter("susie")
	
        cutscene:showNametag("???????")
        cutscene:text("* FORGET ME NOT.")
        cutscene:hideNametag()
        susie:setSprite("shock_right")
        player:explode(0, 0, true)
        flaurel:explode()
        cutscene:wait(0.25)
		
        Assets.stopSound("badexplosion")
        Game.world:remove()

        Game.state = "GAMEOVER"
        Kristal.hideBorder(0)
        Game.stage:addChild(GameOver(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, "what the fuck"))
        Mod:rollFun()
    end,
    elevator_strange = function(cutscene)
        local leader = Mod:getLeader("chara")
        cutscene:after(function()
            Mod:rollFun()
            Game:setFlag("met_strange_girl", true)
        end)

        cutscene:wait(0.25)
        cutscene:wait(cutscene:walkToSpeed(leader, leader.x, leader.y + 20, Game.world.player.walk_speed/2))
        cutscene:wait(0.5)
        cutscene:wait(cutscene:fadeOut(2))
        cutscene:wait(1.5)
        for i,follower in ipairs(Game.world.followers) do
            follower.visible = false
        end
        local x, y = Game.world.map:getMarker("entry_elevator")
        local twin = Game.world:spawnNPC("s_girl", x, y)
        cutscene:wait(cutscene:fadeIn(2))
        cutscene:wait(1.5)
        twin:setSprite("walk/right_2")
        cutscene:wait(cutscene:slideToSpeed(twin, twin.x+50, twin.y, 1.25))
        twin:setSprite("walk/down_2")
        cutscene:wait(cutscene:slideToSpeed(twin, twin.x, twin.y+120, 1.25))
        twin:resetSprite()
        cutscene:wait(1)
        cutscene:setTextboxTop(true)
        cutscene:text("* You're not the one I'm looking for.", nil, twin)
        twin:setSprite("walk/down_4")
        cutscene:wait(cutscene:slideToSpeed(twin, twin.x, SCREEN_HEIGHT+100, 1.25))
        cutscene:wait(cutscene:fadeOut(2))
        cutscene:wait(1.5)
        for i,follower in ipairs(Game.world.followers) do
            follower.visible = true
        end
        twin:remove()
        cutscene:wait(cutscene:fadeIn(2))
        cutscene:wait(1.5)
    end
}
