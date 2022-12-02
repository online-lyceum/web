<template>
    <div>
        <p>Используется class_id = {{ class_id }}</p>
        <h3>Список уроков</h3>
        <ul>
            <li v-for="lesson in lesson_list" :key="lesson.lesson_id">
                <p>{{ lesson.name }} {{ lesson.start_time.hour }}:{{ lesson.start_time.minute}} - {{ lesson.end_time.hour }}:{{ lesson.end_time.minute}}</p>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    data() {
        return {
            lesson_list: []
        }
    },
    methods: {
        async showList() {
            if (this.class_id != ""){
                var res = await fetch("https://dev.lava-land.ru/api/class/" + this.class_id + "/lesson");
                if (res.status == 200){
                    var json_res = await res.json();
                    var lesson_list = json_res.lessons;
                    this.lesson_list = lesson_list;
                }
            } else {
                this.lesson_list = [];
            }
        }
    },
    props: ['class_id'],
    watch: {
        class_id() {
            this.showList();
        }
    }
}
</script>

<style>
</style>
