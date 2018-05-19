const comments = (state = [], action) => {
    switch (action.type) {
        case 'ADD_COMMENT':
            return [
                action,
                ...state

            ];
        default:
            return state
    }
};

export default comments
