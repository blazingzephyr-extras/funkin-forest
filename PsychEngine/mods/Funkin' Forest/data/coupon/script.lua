local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'breakfast');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end









local winner = 0

function onCreate()
    createIcons()
end

function onRecalculateRating()
    calculateWinner()
	return Function_Continue;
end

function onUpdate(elapsed)
    updateIcons()
end

function createIcons()
    makeLuaSprite('winningIconBf', 'icons/icon-'..getProperty('iconP1.animation.curAnim.name')..'-win', getProperty('iconP1.x'), getProperty('iconP1.y'))
	setObjectCamera('winningIconBf', 'hud')
	addLuaSprite('winningIconBf', true)
	setObjectOrder('winningIconBf', getObjectOrder('iconP1') + 1)
	setProperty('winningIconBf.x', getProperty('iconP1.x'))
	setProperty('winningIconBf.y', getProperty('iconP1.y'))
	setProperty('winningIconBf.scale.x', getProperty('iconP1.scale.x'))
	setProperty('winningIconBf.scale.y', getProperty('iconP1.scale.y'))
	setProperty('winningIconBf.flipX', true)
	setProperty('winningIconBf.angle', getProperty('iconP1.angle'))
	setProperty('winningIconBf.visible', false)

	makeLuaSprite('winningIconOpponent', 'icons/icon-'..getProperty('iconP2.animation.curAnim.name')..'-win', getProperty('iconP2.x'), getProperty('iconP2.y'))
	setObjectCamera('winningIconOpponent', 'hud')
	addLuaSprite('winningIconOpponent', true)
	setObjectOrder('winningIconOpponent', getObjectOrder('iconP2') + 1)
	setProperty('winningIconOpponent.x', getProperty('iconP2.x'))
	setProperty('winningIconOpponent.y', getProperty('iconP2.y'))
	setProperty('winningIconOpponent.scale.x', getProperty('iconP2.scale.x'))
	setProperty('winningIconOpponent.scale.y', getProperty('iconP2.scale.y'))
	setProperty('winningIconOpponent.flipX', false)
	setProperty('winningIconOpponent.angle', getProperty('iconP2.angle'))
	setProperty('winningIconOpponent.visible', false)
end

function calculateWinner()
	local health = getProperty('health')
	if health >= 1.6 then
		setProperty('iconP1.visible', false)
		setProperty('winningIconBf.visible', true)
        winner = 1

	elseif health <= 0.3 then 
		setProperty('iconP2.visible', false)
		setProperty('winningIconOpponent.visible', true)
        winner = 2

	else
		setProperty('iconP1.visible', true)
		setProperty('iconP2.visible', true)
		setProperty('winningIconBf.visible', false)
		setProperty('winningIconOpponent.visible', false)
        winner = 0
	end
end

function updateIcons()
    if winner == 1 then
        setProperty('winningIconBf.x', getProperty('iconP1.x'))
        setProperty('winningIconBf.y', getProperty('iconP1.y'))
        setProperty('winningIconBf.scale.x', getProperty('iconP1.scale.x'))
        setProperty('winningIconBf.scale.y', getProperty('iconP1.scale.y'))
        setProperty('winningIconBf.angle', getProperty('iconP1.angle'))
    elseif winner == 2 then
        setProperty('winningIconOpponent.x', getProperty('iconP2.x'))
        setProperty('winningIconOpponent.y', getProperty('iconP2.y'))
        setProperty('winningIconOpponent.scale.x', getProperty('iconP2.scale.x'))
        setProperty('winningIconOpponent.scale.y', getProperty('iconP2.scale.y'))
        setProperty('winningIconOpponent.angle', getProperty('iconP2.angle'))
    end
end