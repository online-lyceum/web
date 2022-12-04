<template>
    <div>
        <h1>Выберете учбеное заведение и группу</h1>
        <form @submit.prevent>
            <input list="schools" name="select_school" v-model="school" @change="selectClass">
            <datalist id="schools">
                <option disabled value="">Учебное заведение</option>
                <option v-for="school in schools" :key="school.school_id" :value="school.name">{{ school.city }}, {{ school.place }}</option>
            </datalist>
            <input @input="selectClass" type="number" placeholder="Класс/курс" v-model="class_number">
            <input list="classes" @input="selectClass" type="text" placeholder="Буква/код" v-model="class_letter">
            <datalist id="classes">
                <option disabled value="">Подгруппа</option>
                <option v-for="class_obj in classes" :key="class_obj.class_id" :value="class_obj.letter"/>
            </datalist>
            <select name="select_subgroup" v-model="subgroup_id" @change="selectSubgroup" v-if="need_to_select_subgroup">
                <option disabled value="">Подгруппа</option>
                <option v-for="subgroup in subgroups" :key="subgroup.subgroup_id" :value="subgroup.subgroup_id">{{ subgroup.name }}</option>
            </select>

        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            schools: [],
            school_id: "",
            class_number: "",
            class_letter: "",
            subgroup_id: "",
            need_to_select_subgroup: false, 
            subgroups: [],
            classes: [],
            school: "",
        }
    },
    methods: {
        async selectClass() {
            if (this.school == ""){
                return
            }
            this.school_id = "";
            this.loadSchools();
            for (var j = 0; j < this.schools.length; j++){
                if (this.school == this.schools[j]['name']){
                    this.school_id = this.schools[j]['school_id'];
                }
            }
            var res = await fetch("https://dev.lava-land.ru/api/school/" + this.school_id+ "/class");
            var class_id = ""
            this.subgroup_id = ""
            this.need_to_select_subgroup = false;
            this.classes = []
            if (res.status == 200){
                var json_res = await res.json();
                this.classes = json_res['classes'];
                for (var i = 0; i < this.classes.length; i++){
                    if ((this.class_number == this.classes[i]['number']) && (this.class_letter.toUpperCase() == this.classes[i]['letter'])){
                        class_id = this.classes[i]['class_id'];
                    }
                }
            }
            if (class_id != ""){
                var subgroups_res = await fetch("https://dev.lava-land.ru/api/class/" + class_id + "/subgroup");
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
            this.selectSubgroup();

        },
        async selectSubgroup(){
            this.$emit('select', this.subgroup_id);
        },
        async loadSchools() {
             var res = await fetch("https://dev.lava-land.ru/api/school");
            if (res.status == 200){
                var json_res = await res.json();
                this.schools = json_res['schools'];
            }
        }
    },
    created() {
        this.loadSchools();
    }
}
</script>

<style>
</style>
