<template>
    <div v-if="school_id === undefined">
        <h1 class="w">Привет</h1>
        <div>
            <div class="my-card" v-for="school in schools" v-bind:key="school.school_id">
                <p>{{ school.name }}</p>
                <p>{{ school.address }}</p>
                <my-button @click="selectSchool" :value="school.school_id">Выбрать</my-button>
            </div>
        </div>
    </div>
    <div v-else>
        <my-button @click="unselectSchool">Назад</my-button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            schools: [],
            school_id: undefined
        }
    },
    mounted(){
        this.loadSchools();
    },
    methods: {
        async loadSchools() {
            var res = await fetch("https://dev.lava-land.ru/api/schools");
            if (res.status == 200){
                var json_res = await res.json();
                this.schools = json_res['schools'];
            }
        },
        selectSchool(event) {
            this.school_id = event.target.value; 
            this.$emit('select', this.school_id);
        },
        unselectSchool() {
            this.school_id = undefined;
            this.$emit('select', this.school_id);
        }
    }

}
</script>

<style scoped>
</style>