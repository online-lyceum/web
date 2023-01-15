<template>
    <div class="header">
        <h1>{{ page }}</h1>
    </div>
</template>

<script>
export default {
    props: {
        page: {
            type: String,
            required: true
        }
    }
}
</script>
<style scoped>
.header {
    display: flex;
    border-bottom-left-radius: 16px;
    border-bottom-right-radius: 16px;
    background: #fff;
}
h1 {
    margin-left: auto;
    margin-right: auto;
}
</style>