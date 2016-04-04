# Description:
#   Make the bot leave the room for a while
#   Only works on XMPP adapter
#
# Dependencies:
#   hubot-xmpp
#
# Commands:
#   hubot go away - Make the bot leave this room 30 minutes
#   hubot stay in here - Make the bot come back to this room on reboots
#   hubot stop coming in here - Make her stop logging in
#
# Author:
#   ivey

module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    console.log robot.brain.data.always_join
    console.log "BLANKING always_join ROOMS FOR SLACK - SAVE THESE"
    robot.brain.data.always_join = []
    robot.adapter.connector.join room for room in robot.brain.data.always_join

  robot.respond /stay in here/i, (msg) ->
    room = msg.message.user.reply_to
    console.log "Request to stay in #{room}"
    unless room in robot.brain.data.always_join
      robot.brain.data.always_join.push room
      console.log robot.brain.data.always_join
      robot.brain.save()
      msg.send "OK. I'll come back here whenever I login."

  robot.respond /stop coming in here/i, (msg) ->
    room = msg.message.user.reply_to
    console.log "Request to stop staying in #{room}"
    if room in robot.brain.data.always_join
      robot.brain.data.always_join = robot.brain.data.always_join.filter (e) -> e != room
      console.log robot.brain.data.always_join
      robot.brain.save()
      msg.send "OK. I'll stop coming in here. Invite me back if you change your mind."
      robot.adapter.connector.part room

  robot.respond /(go away|gtfo)/i, (msg) ->
    room = msg.message.user.reply_to
    msg.reply "OK. I'll come back in around 30 minutes."
    setTimeout (->
      robot.adapter.connector.join room
    ), 1800000
    robot.adapter.connector.part room
