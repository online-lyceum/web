<template>
    <div class="my-card">
        <form @submit.prevent>
            <input @input="selectClass" type="number" placeholder="Класс/курс" v-model="class_number">
            <input @input="selectClass" type="text" placeholder="Буква/код" v-model="class_letter">
            <select name="select_subgroup" v-model="subgroup_id" v-if="need_to_select_subgroup">
                <option disabled value="">Подгруппа</option>
                <option v-for="subgroup in subgroups" :key="subgroup.subgroup_id" :value="subgroup.subgroup_id">{{ subgroup.name }}</option>
            </select>

        </form>
    <my-button @click="selectSubgroup" :disabled="subgroup_id === ''" class="select-button">Выбрать</my-button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            schools: [],
            class_number: "",
            class_letter: "",
            subgroup_id: "",
            need_to_select_subgroup: false, 
            subgroups: [],
        }
    },
    methods: {
        async selectClass() {
            if (this.school_id == ""){
                return
            }
            var res = await fetch("https://dev.lava-land.ru/api/classes?school_id=" + this.school_id);
            var class_id = ""
            this.subgroup_id = ""
            this.need_to_select_subgroup = false;
            if (res.status == 200){
                var json_res = await res.json();
                var classes = json_res['classes'];
                for (var i = 0; i < classes.length; i++){
                    if ((this.class_number == classes[i]['number']) && (this.class_letter.toUpperCase() == classes[i]['letter'].toUpperCase())){
                        class_id = classes[i]['class_id'];
                    }
                } 
            }
            if (class_id != ""){
                var subgroups_res = await fetch("https://dev.lava-land.ru/api/subgroups?class_id=" + class_id);
                if (subgroups_res.status == 200){
                    var json_subgroup_res = await subgroups_res.json();
                    this.subgroups = json_subgroup_res['subgroups'];
                    if (this.subgroups.length == 1){
                        this.subgroup_id = this.subgroups[0].subgroup_id;
                        this.need_to_select_subgroup = false;
                    } else if (this.subgroups.length > 1){
                        this.subgroup_id = "";
                        this.need_to_select_subgroup = true;
                    } else {
                        this.subgroup_id = "";
                        this.has_subgroup = false;
                    }
                } else {
                    this.subgroup_id = "";
                    this.subgroups = []
                }
            }

        },
        async selectSubgroup(){
            console.log("send " + this.subgroup_id);
            if (!(this.subgroup_id === undefined)){
                this.$emit('select', this.subgroup_id);
            }
        },
        async loadSchools() {
             var res = await fetch("https://dev.lava-land.ru/api/schools");
            if (res.status == 200){
                var json_res = await res.json();
                this.schools = json_res['schools'];
            }
        }
    },
    props: {
        school_id: {
            type: String,
            required: true
        }
    }
}
</script>

<style scoped>
.select-button {
    margin-top: 10px;
}
</style>
