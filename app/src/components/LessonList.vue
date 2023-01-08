<template>
    <div>
        <div class="my-card" v-for="weekday in weekdays" :key="weekday.name">
            <h3>{{ weekday_names[weekday] }}</h3>
            <ul>
                <li v-for="lesson in lesson_list.filter(lesson => lesson.weekday === weekday)" :key="lesson.lesson_id">
                    <p> 
                        {{ lesson.name }} 
                        {{ lesson.start_time.hour }}:{{(lesson.start_time.minute < 10 ? '0' : '') + lesson.start_time.minute}} - 
                        {{ lesson.end_time.hour }}:{{(lesson.end_time.minute < 10 ? '0' : '') + lesson.end_time.minute}}
                    </p>
                </li>
            </ul>
        </div>
        
    </div>
</template>

<script>
export default {
    data() {
        return {
            lesson_list: [],
            weekdays: [0, 1, 2, 3, 4, 5, 6],
            weekday_names: ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"],
        }
    },
    methods: {
        async showList() {
            var res = await fetch("https://dev.lava-land.ru/api/lessons?subgroup_id=" + this.subgroup_id);
            if (res.status == 200){
                var json_res = await res.json();
                
                this.lesson_list = json_res.lessons;
            } else {
                this.lesson_list = [];
            }
            console.log(this.lesson_list);
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
