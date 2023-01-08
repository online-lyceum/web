<template>
    <div id="App">
        <select-school @select="selectingSchool" v-if="subgroup_id === undefined"/>
        <select-subgroup :school_id="school_id" @select="selectingSubgroup" v-if="!(school_id === undefined) & (subgroup_id === undefined)"/>
        <lesson-list :subgroup_id="subgroup_id" v-show="!(subgroup_id === undefined)" />
    </div>
</template>

<script>
import SelectSubgroup from "@/components/SelectSubgroup"
import LessonList from "@/components/LessonList"
import SelectSchool from "@/components/SelectSchool.vue"

export default {
  name: 'App',
  data() {
    return {
        school_id: undefined,
        subgroup_id: undefined 
    }
  },
  components: {
    SelectSchool,
    SelectSubgroup,
    LessonList
  },
  methods: {
    selectingSchool(school_id) {
      this.school_id = school_id;
    },
    selectingSubgroup(subgroup_id) {
        console.log('Set subgroup ' + subgroup_id)
        this.subgroup_id = subgroup_id;
    }
  }
}
</script>

<style>
.w {
  color: #fff;
}
body {
    padding: 20px;
    background-color: #0C3B2E;
}
.my-card {
    background-color: #FFF;
    padding: 20px;
    margin-top: 40px;
    border-radius: 16px;
}
</style>
