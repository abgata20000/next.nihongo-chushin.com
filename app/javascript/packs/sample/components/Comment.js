import React from 'react'
import PropTypes from 'prop-types'

const click = (e, id) => {
    e.preventDefault();
    console.log(id);
};

const Comment = (chat) => (
    <li>
        {chat.comment}
        <span>{chat.id}</span>
        <button onClick={e => click(e, chat.id)}>
            button:{chat.id}
        </button>
        <p>
            icon: {chat.icon}
        </p>
        <p>
            color: {chat.color}
        </p>

    </li>
);

Comment.propTypes = {
    id: PropTypes.number.isRequired,
    comment: PropTypes.string.isRequired,
    icon: PropTypes.string,
    color: PropTypes.string,
};

export default Comment
