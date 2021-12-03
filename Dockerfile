FROM public.ecr.aws/lambda/nodejs:14

WORKDIR ${LAMBDA_TASK_ROOT}

COPY package.json package-lock.json ./

COPY . .

RUN npm install

CMD ["index.handler"]