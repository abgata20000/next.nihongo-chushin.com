import request from 'superagent'

let lastChatId = 0;
let fetching = false;
let next_fetch = false;
const chats_url = '/apis/chats';
export const ADD_COMMENT = 'ADD_COMMENT';

export const addComment = (chat) => ({
    type: ADD_COMMENT,
    id: chat.id,
    user_id: chat.user_id,
    room_id: chat.room_id,
    comment: chat.comment,
    icon: chat.icon,
    color: chat.color,
    nickname: chat.nickname,
    system_message: chat.system_message,
    created_at: chat.created_at,
});

export const updateText = (text) => ({
    type: 'UPDATE_TEXT',
    text: text
});

export const resetText = () => ({
    type: 'RESET_TEXT'
});

export const setMention = (name) => ({
    type: 'SET_MENTION',
    name: name
});


export const postComment = (comment) => (dispatch) => {
    request
        .post(chats_url)
        .send({comment: comment})
        .end(function (err, res) {
        });
};

export const fetchComments = () => (dispatch) => {
    if(fetching) {
        next_fetch = true;
        return;
    }
    fetching = true;
    request
        .get(chats_url)
        .query({last_chat_id: lastChatId})
        .end(function (err, res) {
            let chats = res.body;
            chats.forEach(function (chat) {
                let tmp = chat.chat;
                lastChatId = tmp.id;
                dispatch(addComment(tmp));
            });
            fetching = false;
            if(next_fetch) {
                next_fetch = false;
                fetchComments();
            }
        });
};
