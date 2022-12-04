<template>
    <div>
        <p>Используется subgroup_id = {{ subgroup_id }}</p>
        <h3>Список уроков на {{ weekday }}</h3>
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
            lesson_list: [],
            weekday: ""
        }
    },
    methods: {
        async showList() {
            if (this.subgroup_id != ""){
                var res = await fetch("https://dev.lava-land.ru/api/subgroup/" + this.subgroup_id + "/lessons_to_show_today");
                if (res.status == 200){
                    var json_res = await res.json();
                    this.lesson_list = json_res.lessons;
                    var weekdays_names = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"];
                    this.weekday = weekdays_names[json_res.weekday];
                }
            } else {
                this.weekday = "",
                this.lesson_list = [];
            }
        }
    },
    props: ['subgroup_id'],
    watch: {
        subgroup_id() {
            this.showList();
        }
    }
}
</script>

<style>
</style>
