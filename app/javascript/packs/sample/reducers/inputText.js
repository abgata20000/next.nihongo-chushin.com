const inputText = (state = '', action) => {
    switch (action.type) {
        case 'UPDATE_TEXT':
            return action.text;
        case 'RESET_TEXT':
            return '';
        case 'SET_MENTION':
            return ['@', action.name, ' ', state].join('');
        default:
            return state
    }
};

export default inputText
