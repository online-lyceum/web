<template>
    <div>
        <h1>Select class</h1>
        <form @submit.prevent>
            <input type="number" placeholder="class_id" v-model="class_id">
            <button @click="selectClass" >Select</button>
        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            class_id: "" 
        }
    },
    methods: {
        selectClass() {
            this.$emit('select', this.class_id);
        }
    }
}
</script>

<style>
</style>
