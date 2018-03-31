const comments = (state = [], action) => {
    switch (action.type) {
        case 'ADD_COMMENT':
            return [
                {
                    id: action.id,
                    text: action.text
                },
                ...state

            ];
        default:
            return state
    }
};

export default comments
