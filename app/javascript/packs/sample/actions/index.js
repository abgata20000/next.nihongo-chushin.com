import request from 'superagent'

let lastChatId = 0;
let fetching = false;
let next_fetch = false;
const chats_url = '/apis/chats';
export const ADD_COMMENT = 'ADD_COMMENT';

export const addComment = (id, text) => ({
    type: ADD_COMMENT,
    id: id,
    text
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
                dispatch(addComment(tmp.id, tmp.comment));
            });
            fetching = false;
            if(next_fetch) {
                next_fetch = false;
                fetchComments();
            }
        });
};
