import getSession from "../database/queries/retrieve/sessions.js";
import { validateUrl } from "../utils/validationFunctions.js";

const urlShortenMiddleware = async (req, res, next) => {
    try{
        const { authorization } = req.headers;
        const { url } = req.body;
        if(authorization !== undefined){
            const auxToken = authorization.split(' ');
            const token = auxToken[1];
            const activeSession = await getSession(token);
            if(activeSession.rowCount > 0){
                const { rows } = activeSession;
                const { userId, sessionToken, sessionKey } = rows[0];
                if(sessionToken.split('.').find((item) => { return item === token })){
                    const validation = validateUrl({ url });
                    if(validation.status){
                        res.locals.fullUrl = url;
                        res.locals.userId = userId;
                        next();
                        return;
                    }
                    res.status(422).send(validation.error.details);
                    return;
                }
            }
        }
        res.sendStatus(401);
    }catch(e){
        console.log(e.message);
        res.sendStatus(500);
    }
}

export default urlShortenMiddleware;